%          Update The Vector                     Assignment Week 7
%          Sander Martijn Kerkdijk               Max Turpijn
%          Course: Behaviour Dynamics in social Networks 
%               Vrije Universiteit Amsterdam 2015
%                    Copying will be punished

function Vector = UpdateVector( para_values, WeightVector )
% Update assigned weights on given places in the WeightVector.

%Real place              Para_value(Place)  %(From)(To)
WeightVector(1,2)   =   para_values(1);     %AB
WeightVector(1,3)   =   para_values(2);     %AC
WeightVector(1,4)   =   para_values(3);     %AD
WeightVector(1,5)   =   para_values(4);     %AE
WeightVector(2,1)   =   para_values(5);     %BA
WeightVector(2,5)   =   para_values(6);     %BE
WeightVector(2,6)   =   para_values(7);     %BF
WeightVector(3,1)   =   para_values(8);     %CA
WeightVector(3,5)   =   para_values(9);     %CE
WeightVector(3,7)   =   para_values(10);    %CG
WeightVector(4,1)   =   para_values(11);    %DA
WeightVector(4,7)   =   para_values(12);    %DG
WeightVector(4,8)   =   para_values(13);    %DH
WeightVector(4,9)   =   para_values(14);    %DI
WeightVector(5,1)   =   para_values(15);    %EA
WeightVector(5,2)   =   para_values(16);    %EB
WeightVector(5,3)   =   para_values(17);    %EC
WeightVector(5,6)   =   para_values(18);    %EF
WeightVector(5,7)   =   para_values(19);    %EG
WeightVector(5,10)  =   para_values(20);    %EJ
WeightVector(5,11)  =   para_values(21);    %EK
WeightVector(6,2)   =   para_values(22);    %FB
WeightVector(6,5)   =   para_values(23);    %FE
WeightVector(6,10)  =   para_values(24);    %FJ
WeightVector(6,12)  =   para_values(25);    %FL
WeightVector(7,3)   =   para_values(26);    %GC 
WeightVector(7,4)   =   para_values(27);    %GD
WeightVector(7,5)   =   para_values(28);    %GE
WeightVector(7,8)   =   para_values(29);    %GH
WeightVector(7,11)  =   para_values(30);    %GK
WeightVector(8,4)   =   para_values(31);    %HD
WeightVector(8,7)   =   para_values(32);    %HG
WeightVector(8,9)   =   para_values(33);    %HI
WeightVector(8,11)  =   para_values(34);    %HK
WeightVector(9,4)   =   para_values(35);    %ID
WeightVector(9,8)   =   para_values(36);    %IH
WeightVector(10,5)  =   para_values(37);    %JE
WeightVector(10,6)  =   para_values(38);    %JF
WeightVector(10,11) =   para_values(39);    %JK
WeightVector(10,12) =   para_values(40);    %JL
WeightVector(11,5)  =   para_values(41);    %KE
WeightVector(11,7)  =   para_values(42);    %KG 
WeightVector(11,8)  =   para_values(43);    %KH
WeightVector(11,10) =   para_values(44);    %KJ
WeightVector(11,12) =   para_values(45);    %KL
WeightVector(12,6)  =   para_values(46);    %LF
WeightVector(12,10) =   para_values(47);    %LJ
WeightVector(12,11) =   para_values(48);    %LK

% Return WeightVector
Vector = WeightVector;
end
