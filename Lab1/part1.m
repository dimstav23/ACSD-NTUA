%PD Controller
%Meros A
%Stavrakakis Dimitrios
%AM: 03112017
%Sxediash Systhmatwn Aytomatou Elegxou 2017
close all;
clear all;

%Ekxwrhsh timwn sta kp kd (symperilamvanwmenou tou K)
kp = 200;%210
kd = 0.475;%0.5
%fs = 8000;%Syxnothta deigmatolhpsias 8kHz
%Tf = 0.2;%Xronos prosomoiwshs gia optikopoihsh monimhs katastashs 0.2sec --> 1600 deigmata
%Dhmioyrgia ths synarthshs metaforas tou systhmatos mas
%kateytheian klados / (1+gyrw-gyrw)
%(4500kp+4500kd*s)/(s^2 + (361.2+4500kd)*s + 4500kp)
nom_1 = 4500*kd;
nom_2 = 4500*kp;
denom_1 = 1;
denom_2 = 361.2+nom_1;
denom_3 = nom_2;

sys = tf([nom_1,nom_2], [denom_1,denom_2,denom_3]);
t = linspace(0,0.2,1600);%0:1/fs:Tf; 0-0.2sec 1600deigmata -> 8kHz syxnothta deigmatolhpsias
%Kataskeyh synarthshs eisodou tou systhmatos mas
%R = t.*heaviside(t);
%t = -1:0.001:1;
R = ones( size(t) ) .* (t >= 0) ;
R=R.*t;
figure(1);
plot(t,R);
title('Input Ramp');
xlabel('time(sec)');

Y = lsim(sys,R,t); %edw kanoume to simulation tou systhmatos me thn epi8ymhth eisodo mas
error = abs(Y' - R); %afairontas apo to apotelesma mas thn eisodo tou vriskoume to error
                     %kai vlepoume an einai oso to epi8ymhto pou zhteitai
figure(2);
plot(t,Y);
title('Output');
xlabel('time(sec)');
figure(3);
plot(t, error);
title('Error');
xlabel('Time(sec)');
assert(all(error<0.2),'Large error')
%Plrofories gia th vhmatikh synarthsh oson afora to systhma mas
figure(4);
stepplot(sys);
stepinfo(sys)