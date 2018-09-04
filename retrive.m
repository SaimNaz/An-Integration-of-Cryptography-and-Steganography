%decryption program
clc
close all
s = imread('msgimage.png');
n=size(s); %dimension of image
txtsz = double(s(n(1),n(2),1))*255+double(s(n(1),n(2),2));  %Extract size of message in bytes from last pixel
height = size(s,1); %(s,1) means 1st dimension of s i.e rows
width = size(s,2);
m = txtsz*8;    %convert message size to bits
b = zeros(m,1);
k = 1;
for i = 1 : height
  for j = 1 : width
      if (k <= m)
          b(k) = mod(double(s(i,j)),2); %extract message
          k = k + 1;
      end
  end
end
binValues = [ 128 64 32 16 8 4 2 1 ];
binMatrix = reshape(b,8,[]); %Convert vector into matrix of 8 rows;
textString = char(binValues*binMatrix); %Convert binary matrix to decimal and then typecast to char
disp(textString);