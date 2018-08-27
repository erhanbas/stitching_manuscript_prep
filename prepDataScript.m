function prepDataScript()
addpath(genpath('./common'))
addpath(genpath('./functions'))

input_sample = '2018-08-01'
% input_render_folder = '/nrs/mouselight/SAMPLES/2018-08-01-raw-rerender'
input_raw_folder = '/groups/mousebrainmicro/mousebrainmicro/data/acquisition/2018-08-01'
output_raw_folder = './datafold'
crop_BB_left_top = [72438.8, 16877.1, 38560.1]; % /groups/mousebrainmicro/mousebrainmicro/data/acquisition/2018-08-01/2018-08-13/00/00174/00174-ngc.0.tif
crop_BB_right_bottom = [73296.4, 17612.2, 39200.6];


if ~exist(output_raw_folder)
    mkdir(output_raw_folder)
end
params = configparser(fullfile(input_render_folder,'transform.txt'));
siz = [1024 1536 251];
newdash = 1; % set this to 1 for datasets acquired after 160404
[scopeloc] = getScopeCoordinates(input_raw_folder,newdash);% parse from acqusition files
[neighbors] = buildNeighbor(scopeloc.gridix(:,1:3)); %[id -x -y +x +y -z +z] format

% find tiles within bounding box
FOV = [params.sx params.sy params.sz]/2^(params.nl-1)/1e3.*[siz]; % in um

tilelocs = scopeloc.loc*1e3;

%%
% render/scope flips x&y but keep z
idx1 = utils.getIndex(crop_BB_left_top,tilelocs,FOV);
idx2 = utils.getIndex(crop_BB_right_bottom,tilelocs,FOV);

gridloc1 = scopeloc.gridix(idx1,:);
gridloc2 = scopeloc.gridix(idx2,:);
filepath1 = scopeloc.filepath(idx1);
filepath2 = scopeloc.filepath(idx2);

idx_in_BB = find(scopeloc.gridix(:,1)>=gridloc1(1) & scopeloc.gridix(:,1)<=gridloc2(1)& ...
    scopeloc.gridix(:,2)>=gridloc1(2) & scopeloc.gridix(:,2)<=gridloc2(2)& ...
    scopeloc.gridix(:,3)>=gridloc1(3) & scopeloc.gridix(:,3)<=gridloc2(3))
scopeloc.gridix(idx_in_BB,:);
% copy tiles into target folder
for ii =1:lenght(idx_in_BB)
    ifiles = idx_in_BB(ii);
    input_foldername = fullfile(input_raw_folder,scopeloc.relativepaths{ifiles});
    output_foldername = fullfile(output_raw_folder,scopeloc.relativepaths{ifiles});
    if ~exist(output_foldername,'dir'), mkdir(output_foldername); end
    unix(sprintf('cp %s %s'),input_foldername,output_foldername)
    
end




%%


(min(tilelocs))
(max(tilelocs))

tiles = getTiles(scopeloc,crop_BB_left_top)


end