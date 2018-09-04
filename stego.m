%Encryption program
clc
close all
c = imread('cover.jpg'); %Read cover image
fid=fopen('message.txt','r'); %Open the message file and return file descriptor
F = fread(fid); %Read data into column vector F in ascii format
m = length(F) * 8; %Each char is 1 byte so find total bits
asciimsg = F';   %convert cloumn to row vector
binmsg = (dec2bin(asciimsg,8))'; %convert message into binary array with 8 bits per letter
binmsg = binmsg(:); %align all column into single column
N = length(binmsg);
b = zeros(N,1); %create an array of zeros of size N*1
for k = 1:N %copy binmsg to b
  if(binmsg(k) == '1')
      b(k) = 1;
  else
      b(k) = 0;
  end
end
s = c;
  height = size(c,1);
  width = size(c,2);
k = 1;
display(c(300,400));
display(c(300,400)-1);
for i = 1 : height
  for j = 1 : width
      LSB = mod(double(c(i,j)), 2); %LSB of pixel
      if (k>m || LSB == b(k)) %If k beyond message length or LSB is same as message bit
          s(i,j) = c(i,j); %Output image pixel same as cover imaage
      elseif(LSB == 1)
          s(i,j) = (c(i,j) - 1); %decrement pixel value by 1 if LSB=1
      elseif(LSB == 0)
          s(i,j) = (c(i,j) + 1); %increment pixel value by 1 if LSB=0
      end
  k = k + 1;
  end
end
letters=m/8;
%display(letters);
s(height,width,1) = floor(letters/255); %store message size in last pixel
s(height,width,2) = mod(letters,255);
%display(s(height,width,2));
imgWTxt = 'msgimage.png';
imwrite(s,imgWTxt);
imshow('msgimage.png');
%display(psnr(s,c));