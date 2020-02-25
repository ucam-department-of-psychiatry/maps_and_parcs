function out = map2map(annot1, annot2, indir, outfile)

% maps one parcellation to another and output a csv of largest to smallest
% alongside goodness of fit

%% get the first annotation file
lh_annot1 = strcat("lh.",annot1,".annot");
rh_annot1 = strcat("rh.",annot1,".annot");
[~, lh_l1, lh_ctb1] = read_annotation(strcat(indir,'/',lh_annot1));
[~, rh_l1, rh_ctb1] = read_annotation(strcat(indir,'/',lh_annot1));

%% get the second annotation file
lh_annot2 = strcat("lh.",annot2,".annot");
rh_annot2 = strcat("rh.",annot2,".annot");
[~, lh_l2, lh_ctb2] = read_annotation(strcat(indir,'/',lh_annot2));
[~, rh_l2, rh_ctb2] = read_annotation(strcat(indir,'/',lh_annot2));


%% check they are the same size
try (size(lh_l1) == size(lh_l2))
    
    display("congratulations your annotation files are the same size");
    
    %% convert both to classes
    [firstclass firstlabel] = annot2classes2labels(strcat(indir,'/',lh_annot1),strcat(indir,'/',rh_annot1),1);
    [secondclass secondlabel] = annot2classes2labels(strcat(indir,'/',lh_annot2),strcat(indir,'/',rh_annot2),1);
    
    idx = unique(firstclass);
    map1 = nan(length(idx),1);
    map2 = nan(length(idx),1);
    fit = nan(length(idx),1);
    label1 = cell(length(idx), 1);
    label2 = cell(length(idx), 1);
    for i = 1:length(idx)
        map1(i) = i;
        mask = firstclass == idx(i);
        temp = secondclass(mask);
        map2(i) = mode(temp);
        fit(i) = length(temp(temp == mode(temp)))/length(temp)*100;
        
        firstlabelfit = firstlabel(mask);
        label1{i} = firstlabelfit{1};
        secondlabelfit = secondlabel(mask);
        secondlabelfit = secondlabelfit(temp == mode(temp));
        label2{i} = secondlabelfit{1};
    end
    
    out = array2table([num2cell(map1),num2cell(map2), num2cell(fit), label1, label2], 'VariableNames', {'annot1_idx', 'annot2_idx', 'Gof','label1','label2'});
    
    writetable(out,strcat(outfile));
    
catch
    display("darn it your annotation files don't seem to match... game over..");
end