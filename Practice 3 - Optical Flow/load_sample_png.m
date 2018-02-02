function sample = load_sample_png

[filename,pathname] = uigetfile('*.png','Select a png file');
sample = double(imread(fullfile(pathname, filename),'png'));
imshow(uint8(sample));

end