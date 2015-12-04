function [ fileContent ] = readList( filename )
%READLIST Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(filename);
lineContent=0;
fileContent=[];
i=1;
while(lineContent~=-1)
    lineContent=fgetl(fid);
    fileContent=char(fileContent,num2str(lineContent));
    i=i+1;
end
fclose(fid);

fileContent(end,:) = '';

end

