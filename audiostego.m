clc
close all
audio = audioread('ambiance.wav');
audiobinary = dec2bin( typecast( single(audio(:)), 'uint8'),8); %all audio bits,single precision,typecasted to 8 bit audio
orig_size = size(audio);
%sound(audio,44100);
cover = audiobinary';
%display(cover(:,1));  %all elements in column 1
%display(size(cover));
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
height = size(cover,1);
width = size(cover,2);
k = 1;
output = cover;
%display(width);
for j = 1 : width
    LSB = cover(8,j); %LSB of pixel
    if (k>m || LSB == b(k)) %If k beyond message length or LSB is same as message bit
        output(8,j) = cover(8,j); %Output image pixel same as cover imaage
    elseif(LSB == 1)
        output(8,j) = 1;
    elseif(LSB == 0)
        output(8,j) = 0;
    end
    k = k + 1;
end
display(size(output));
%{
length = dec2bin(m);
i = 1;
for j = width - size(length) : width
    output(8,j) = length(i);
    i = i + 1;
end
%}
%display(output);
wavdata = typecast(uint8( bin2dec(char(output') )), 'single' );
display(size(wavdata));
%display(wavdata);
finalop = reshape(wavdata,orig_size);
%finalop = restypecast(bin2dec(uint8(output')));
audiowrite('encrypt.wav',finalop,44100);
%sound(wavdata,44100);
%letters=m/8;
%display(letters);
%output(height,width,1) = floor(letters/255); %store message size in last pixel
%output(height,width,2) = mod(letters,255);
%display(psnr(s,c));
%}