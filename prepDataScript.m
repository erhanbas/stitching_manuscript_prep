function prepDataScript()
addpath(genpath('./common'))
addpath(genpath('./functions'))

input_sample = '2018-08-01'
% input_render_folder = '/nrs/mouselight/SAMPLES/2018-08-01-raw-rerender'
input_raw_folder = '/groups/mousebrainmicro/mousebrainmicro/data/acquisition/2018-08-01'
output_raw_folder = './datafold'
crop_BB_left_top = [72438.8, 16877.1, 38560.1];
crop_BB_right_bottom = [73296.4, 17612.2, 39200.6];


if ~exist(output_raw_folder)
    mkdir(output_raw_folder)
end
params = configparser(fullfile(input_render_folder,'transform.txt'));

newdash = 1; % set this to 1 for datasets acquired after 160404
[scopeloc] = getScopeCoordinates(input_raw_folder,newdash);% parse from acqusition files
[neighbors] = buildNeighbor(scopeloc.gridix(:,1:3)); %[id -x -y +x +y -z +z] format



end