function out = map2map_centroid(annot1, annot2, annotdir,spheredir, outfile)

% maps one parcellation to another and output a csv of largest to smallest
% alongside goodness of fit

%% get the first annotation file
lh_annot1 = strcat("lh.",annot1,".annot");
rh_annot1 = strcat("rh.",annot1,".annot");
[~, lh_l1, lh_ctb1] = read_annotation(strcat(annotdir,'/',lh_annot1));
[~, rh_l1, rh_ctb1] = read_annotation(strcat(annotdir,'/',lh_annot1));

%% get centroids and labels
[centroid_lh labels_lh]= centroid_extraction_sphere(strcat(spheredir,'/lh.sphere'),strcat(annotdir,'/',lh_annot1));
[centroid_rh labels_rh]= centroid_extraction_sphere(strcat(spheredir,'/lh.sphere'),strcat(annotdir,'/',rh_annot1));
centroid_1 = [centroid_lh; centroid_rh];
labels_1 = [strcat('lh_',labels_lh); strcat('rh_',labels_rh)];

%% get the second annotation file
lh_annot2 = strcat("lh.",annot2,".annot");
rh_annot2 = strcat("rh.",annot2,".annot");
[~, lh_l2, lh_ctb2] = read_annotation(strcat(annotdir,'/',lh_annot2));
[~, rh_l2, rh_ctb2] = read_annotation(strcat(annotdir,'/',lh_annot2));

%% get centroids and labels
[centroid_lh labels_lh] = centroid_extraction_sphere(strcat(spheredir,'lh.sphere'),strcat(annotdir,'/',lh_annot2));
[centroid_rh labels_rh] = centroid_extraction_sphere(strcat(spheredir,'rh.sphere'),strcat(annotdir,'/',rh_annot2));
centroid_2 = [centroid_lh; centroid_rh];
labels_2 = [strcat('lh_',labels_lh); strcat('rh_',labels_rh)];

%%
try

    display("congratulations you can continue");
    % Find nearest neighbors in file 2 and the corresponding values to each
    % point in file 1 using euclidean distance
   [idx, dist] = knnsearch(centroid_2,centroid_1,'dist','euclidean','k',1);

   label1 = cell(length(idx), 1);
   label2 = cell(length(idx), 1);
   for i = 1:length(idx)
        label1{i} = labels_1{i};
        label2{i} = labels_2{idx(i)};
   end

   out = array2table([num2cell(1:1:length(idx))', num2cell(idx), num2cell(dist), label1, label2], 'VariableNames', {'annot1_idx', 'annot2_idx', 'distance','label1','label2'});
   writetable(out,strcat(outfile));

catch
    display("something went wrong ... game over...");
end
