%相机内参数矩阵 intrinsic_matrix:
clc;
%format shortg
M = [2604.390249088141, 0, 656.3964270332482;
  0, 2612.900232314529, 469.9583986626;
  0, 0, 1];
%畸变系数 distortion_coeffs 摄像机的4个畸变系数：(k_1, k_2, p_1, p_2)
DC = [-0.188247840080386, 0.4982781800110627, 0.003645849013464749, 0.00425919004196982, -5.98819485613393];
R = [0.998544981959452, -0.002135481425538684, 0.0538828240043046;
  0.007049955527996711, 0.9958092522658807, -0.09118240635517921;
  -0.05346229634659321, 0.09142960582190507, 0.9943753868879701];

T = [-203.5108505219442;
  -148.8902554644998;
  773.1480428881208];
%像元尺寸 单位 mm
dx = 4.65 *0.001;
dy = 4.65 *0.001;

f = (M(1)*dx+M(5)*dy)/2;
%原点坐标（图像物理坐标系）
u0 = M(7);
v0 = M(8);
A = [1/dx 0 u0;
    0 1/dy v0;
    0 0 1];
A =inv(A);
%图像像素坐标转换到图像物理坐标
fileID = fopen('test.txt','r');
formatSpec = '%f %f';
sizePointSeque = [2 Inf];
PointSeque = fscanf(fileID,formatSpec,sizePointSeque);
fclose(fileID);
fid = fopen('exp.txt', 'w');
point_sequence = [];
N =99;
piexl_point1_sequence =[];
for i=1:N;
    piexl_point1= [  PointSeque(2*i-1);
                     PointSeque(2*i);
                     1   ];
    piexl_point1_sequence = [piexl_point1_sequence piexl_point1];
   
    c = Distortion(piexl_point1);
    p1 =Physical_Point(c);
    p1 = rot90(p1,1);
    point_sequence = [point_sequence;p1];
   % fprintf(fid, '%f %f %f\n', p1);
end

size(point_sequence);

for i=1:98
    piexl_point1_sequence(:,i);
    piexl_point1_sequence(:,i+1);
    %point_sequence(i,:)
    %point_sequence(i+1,:)
    if(mod(i,11) ==0)
        continue;
    else
        {
         norm(point_sequence(i,:)-point_sequence(i+1,:));
        }
    end
end


% P1 =[466.912, 604.183];
% piexl_point1= [  P1(1);
%                  P1(2);
%                  1   ];
% point1 = inv(A)*piexl_point1;
% 
% P2 = [570.401, 603.436];
% piexl_point2 = [P2(1);
%                 P2(2);
%                 1   ];
% point2 = inv(A)*piexl_point2;
%point1 = originpoint;
%point1 = point2;
% %对每个图像坐标系的坐标计算对应的空间点的坐标

% r = sqrt((point1(1)-originpoint(1))^2+(point1(2)-originpoint(2))^2);
% 
% radial_distortion =(1+DC(1)*r^2+DC(2)*r^4);% 1+k1*r^2+k2*r^4
% tangential_distortion = [ 2*DC(3)*point1(1)*point1(2)+DC(4)*(r^2+2*point1(1)^2) ;
%                           DC(3)*(r^2+2*point1(2)^2)+2*DC(4)*point1(1)*point1(2)  ];
% %[2*p1*x*y+p2*(r^2+2*x^2)  p1*(r^2+2*y^2)+2*p*x*y]
% c = radial_distortion*pointto2d+tangential_distortion;
%piexl_point1除去畸变图像上物理坐标


 %p2 =Physical_Point(point2);

 %norm(p1-p2)

% %旋转矩阵和平移矩阵合起来的矩阵
% M1 =[R T;0 0 0 1];
% 
% Q1 = [0; 0; 0; 1];
% Q2 = [0; 0; 1;1];
% 
% C1 = M1*Q1;
% %[  t1
% %   t2
% %   t3  ]
% C2 = M1*Q2;
% %[  Xc
% %   Yc
% %   Zc  ]
% 
% V = [c;f] ;%直线方向向量
% VP = C2-C1;%平面方向向量
% VPV_fenzi1= VP(1)*C1(1)+VP(2)*C1(2)+VP(3)*C1(3);% t1*m1 + t2*m2 + t2*m2
% VPV_fenmu = VP(1)*V(1)+VP(2)*V(2)+VP(3)*V(3);  % um1 + vm2 + zm3
% t = VPV_fenzi1/VPV_fenmu;
% P =t*V

 






 









