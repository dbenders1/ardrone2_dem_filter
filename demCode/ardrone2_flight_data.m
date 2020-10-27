function [t,ts,u,x,y,sigma,s,A,B,C] = ardrone2_flight_data
% load ardrone2FlightDataZ_UZeroed.mat t ts uLin xLin yLin ySigma yS yS2 A B C;
% load ardrone2FlightData5.mat t ts uLin xLin yLin ySigma yS A B C;
load ardrone2FlightData5_UZeroed.mat t ts uLin xLin yLin ySigma yS A B C;
u = uLin;
x = xLin';
y = yLin';
sigma = ySigma;
s = yS;
end