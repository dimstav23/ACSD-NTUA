%PI Controller
%Meros B
%Stavrakakis Dimitrios
%AM: 03112017
%Sxediash Systhmatwn Aytomatou Elegxou 2017
close all;
clear all;

%Ekxwrhsh timwn sta kp ki (symperilamvanwmenou tou K)
kp = 14.5;
ki = 10;

%We also pick a 5 kHz sampling frequency, and a final time of 0.1 sec.
%Fs = 1000;
%T_f = 10;

%Dhmioyrgia ths synarthshs metaforas tou systhmatos mas
%kateytheian klados / (1+gyrw-gyrw)
%(4500kp*s+4500ki)/(s^3 + 361.2*s^2 + 4500kp*s+4500ki)
nom_1 = 4500*kp;
nom_2 = 4500*ki;
denom_1 = 1;
denom_2 = 361.2;
denom_3 = nom_1;
denom_4 = nom_2;

sys = tf([nom_1 nom_2], [denom_1 denom_2 denom_3 denom_4]);
%t = 0:1/Fs:T_f;
t = linspace(0,20,100000); %20 sec,100000deigmata -> 5kHz syxnothta deigmatolhpsias
%Kataskeyh synarthshs eisodou tou systhmatos mas
R = ones( size(t) ) .* (t >= 0) ;
R = ((t.^2)./2).*R;
%plot(t,y);
%R = ((t.^2)./2).*heaviside(t);
figure(1);
plot(t,R);
title('Input Parabola');
xlabel('time(sec)');
Y = lsim(sys,R,t);%edw kanoume to simulation tou systhmatos me thn epi8ymhth eisodo mas
error = abs(Y' - R); %afairontas apo to apotelesma mas thn eisodo tou vriskoume to error
                     %kai vlepoume an einai oso to epi8ymhto pou zhteitai
figure(2);
plot(t,Y);
title('Output');
xlabel('time(sec)');
figure(3);
plot(t, error);
%debugging for error
title('Parabolic Response: Absolute Error');
xlabel('time(sec)');
assert(all(error<0.2),'Large error')
%Plrofories gia th vhmatikh synarthsh oson afora to systhma mas
figure(4);
step(sys);
stepinfo(sys)