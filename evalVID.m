% Demo for Edge Boxes (please see readme.txt first).

debug = 0;

%% load pre-trained edge detection model and set opts (see edgesDemo.m)
model=load('models/forest/modelBsds'); model=model.model;
model.opts.multiscale=0; model.opts.sharpen=2; model.opts.nThreads=4;

%% set up opts for edgeBoxes (see edgeBoxes.m)
opts = edgeBoxes;
opts.alpha = .65;     % step size of sliding window search
opts.beta  = .75;     % nms threshold for object proposals
opts.minScore = .08;  % min score of boxes to detect
opts.maxBoxes = 1e4;  % max number of boxes to detect

% Modified: commented out on April 3rd
% I = imread('contrast.png');
% opts.name = 'rawContrast.mat';
% opts.savename = 'boxContrast.mat';
% % I = imread(sprintf('/disk2/bingbin/ILSVRC2015/Data/VID/train/ILSVRC2015_VID_train_0000/ILSVRC2015_train_0000%s/000000.JPEG'), snippet_id);
% tic, bbs=edgeBoxes(I,model,opts); toc
% 
% I = imread('orig.jpg');
% opts.name = 'rawOrig.mat';
% opts.savename = 'boxOrig.mat';
% tic, bbs=edgeBoxes(I,model,opts); toc
% 
% exit;

% Modified: commented out showRes
% figure(1); % bbGt('showRes',I,gtRes,dtRes(dtRes(:,6)==1,:));
% title('green=matched gt  red=missed gt  dashed-green=matched detect');
% imwrite(I,'savedImgs/box-demo.jpg');

%% run and evaluate on entire dataset (see boxesData.m and boxesEval.m)
% if(~exist('boxes/VOCdevkit/','dir')), return; end
split='train'; data=boxesDataVID('split',split);
nm='EdgeBoxes_VID_sampled_double'; opts.name=['boxes/' nm '-' split '.mat'];
disp(sprintf('# of data.imgs: %d', length(data.imgs)))
edgeBoxes(data.imgs,model,opts); opts.name=[];
% Modified: save to file
% boxesEval('data',data,'names',nm,'thrs',.7,'show',2);
% boxesEval('data',data,'names',nm,'thrs',.5:.05:1,'cnts',1000,'show',3);
% boxesEval('data',data,'names',nm,'thrs',.7,'fName','thres-7');
% boxesEval('data',data,'names',nm,'thrs',.7,'fName','thres-7', resDir, 'output/');
