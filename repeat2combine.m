function varargout = repeat2combine(dim, varargin)
% Repeat arrays elements to get all combinations.
% 
% Syntax
%   [B1, B2] = repeat2combine(dim, A1, A2)
%   [B1, B2, B3,... Bn] = repeat2combine(dim, A1, A2, A3... An)
%   
% Description
%   [B1, B2] = repeat2combine(dim, A1, A2) repeates the elements of the 
%   arrays (e.g., column vectors) A1 and A2 along the dimension specified
%   by dim (e.g., 1) to get all combinations. The input arrays have not to
%   be of the same class.
%   
%   For n-dimensional arrays, all elements along dimensions other than dim,
%   are considered as a single element, for instance, if A1 and A2 are 2D
%   arrays and dim is set to 1 (column), then each row are considered as a
%   single entity or element.
%   
%   [B1, B2, B3,... Bn] = repeat2combine(dim, A1, A2, A3... An) repeats the
%   elements of all the input arrays A1, A2, A3... An, alongs the dimension
%   dim.
% 
% Input arguments
%   An - Arrays with elements to repeat.
%        Data type: numeric | char | cell | logical | categorical | table
%                   struct | datetime | timeseries
%        Size     : (any size)
% 
% Output arguments 
%   Bn - Arrays with repeated elements.
%        Data type: (same as An)
%        Size     : (same as An, but the dimension dim is expanded as much
%                    as necessary)
% 
% Notes
%   The argument dim must be less or iqual than the number of dimensions of
%   each input array.
%   
%   If the argument dim is set along a singleton dimension there are no
%   repetitions because there are an unique element, for instance:
%   if A1, A2 are row vectors, then [B1, B2] = repeat2combine(1, A1, A2)
%   will return B1 = A1 and B2 = A2.
% 
% Examples
%   Example 1: repeate elements of two numeric vectors along the first
%              and second dimensions to get all combinations.
%   A1 = [1, 2, 3];
%   A2 = [10, 20, 30];
%   [B1, B2] = repeat2combine(1, A1, A2); % Notice that along the first dim
%                                         % there are an unique element (row).
%   [B1, B2, B3] = repeat2combine(2, A1, A2, A3);
% 
%   Example 2: repeate elements of three numeric vectors to get all 
%              combinations in an unique array.
%   A1 = 1:2;
%   A2 = 10:10:30;
%   A3 = 100:100:200;
%   [B1, B2, B3] = repeat2combine(2, A1, A2, A3);
%   arrayOfCombinations = cat(1, B1, B2, B3);
% 
%   Example 2: repeat elements of three character vectors to get all 
%              combinations in an unique array.
%   A1 = 'abc';
%   A2 = 'xy';
%   A3 = 'jkl';
%   [B1, B2, B3] = repeat2combine(2, A1, A2, A3); 
%   arrayOfCombinations = cat(1, B1, B2, B3);
% 
%   Example 3: repeate elements of three cell vectors to get combinations
%              in an unique array.
%   A1 = {'a'; 'b'; 'c'};
%   A2 = {'x'; 'y'; 'z'};
%   A3 = {'1'; '2'; '3'};
%   [B1, B2, B3] = repeat2combine(1, A1, A2, A3);
%   arrayOfCombinations = cat(2, B1, B2, B3);
% 
%   Example 4: repeat elements of three arrays with different class to get
%              all combinations.
%   A1 = [10, 20; 30, 40];
%   A2 = {'a', 'b', 'c'; 'd', 'e', 'f'};
%   A3 = struct('color', {'red'; 'blue'; 'grey'},...
%               'size', {'medium'; 'small'; 'large'});
%   [B1, B2, B3] = repeat2combine(1, A1, A2, A3); We cannot concatenate.
% 
% See also
%   ndgrid permute fliplr
% Copyright 2017 Brayan Torres Zagastizabal 
% brayantz_13@hotmail.com
% Check dimensions.
narginchk(2, Inf)
hasRequestedDim = cellfun(@(x) ndims(x) >= dim, varargin);
if ~all(hasRequestedDim)
    error([mfilename ':dimensionMismatch'],...
          ['Dimension mismatch occurred. '...
           '\nInputs arrays must have the dimension specified by the '...
           'argument ''dim''']);
end
% Repeat elements to get all combinations.
dimIndexArray = cellfun(@(x) 1:size(x, dim), varargin, 'UniformOutput', false);
nArrays = length(varargin);
dimIndexGrids = cell(1, nArrays);
[dimIndexGrids{:}] = ndgrid(dimIndexArray{:});
repeatedArray = cell(nArrays, 1);
for i = 1:nArrays
    indexArray = arrayfun(@(x) 1:x, size(varargin{i}), 'UniformOutput',...
                          false);
    dimIndex = permute(dimIndexGrids{i}, fliplr(1:ndims(dimIndexGrids{i})));
    indexArray{dim} = dimIndex(:);
    repeatedArray{i} = varargin{i}(indexArray{:});
end
varargout = repeatedArray;
end