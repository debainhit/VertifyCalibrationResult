function  [point_Xp] = Distortion(point_pixel)

M = [2604.390249088141, 0, 640
  0, 2612.900232314529, 480;
  0, 0, 1];
%畸变系数 distortion_coeffs 摄像机的4个畸变系数：(k_1, k_2, p_1, p_2, k_3)
%DC = [-0.1777342690167931, 0.1995129658624437, 0.0003363315291748914, 0.001306546564784519, -1.825238998376129];
DC = [-0.1775423776863596, 0.1992316324970388, 0.000302855367031889, 0.001303159284352111, -1.861070924777517];
% DC = [-0.179189569928887, 0.2251692460243607, 0.0003844380119724354, 0.001356307601537432, -1.894843108814388];
dx = 4.65 *0.001;
dy = 4.65 *0.001;
 
u0 = M(7);
v0 = M(8);
u1 = 656.3964270332482;
v1 = 469.9583986626;
A = [1/dx 0 u0;
    0 1/dy v0;
    0 0 1];

piexl_originpoint= [ u1;
                     v1;
                     1 ];
% originpoint = [ u1*dx;
%                 v1*dy];
originpoint = inv(A)*piexl_originpoint;
% point = [point(1)*dx;
%          point(1)*dy]
point = inv(A)*point_pixel

fx = M(1)*dx;
fy = M(5)*dy;
point_point_Xn = [ (point(1)-originpoint(1))/fx;
                   (point(2)-originpoint(2))/fy
                    ]
r = sqrt(point_point_Xn(1)^2+point_point_Xn(2)^2);

radial_distortion =(1+(r^2)*DC(1)+(r^4)*DC(2)+(r^6)*DC(5));% 1+k1*r^2+k2*r^4
%radial_distortion =(1+r^2*DC(1))
%radial_distortion =1
tangential_distortion = [ 2*DC(3)*point_point_Xn(1)*point_point_Xn(2)+DC(4)*(r^2+2*point_point_Xn(1)^2) ;
                          DC(3)*(r^2+2*point_point_Xn(2)^2)+2*DC(4)*point_point_Xn(1)*point_point_Xn(2)  ];
%[2*p1*x*y+p2*(r^2+2*x^2)  p1*(r^2+2*y^2)+2*p*x*y]
point_Xd = (radial_distortion*point_point_Xn+tangential_distortion);

point_Xp = [  fx*point_Xd(1)+originpoint(1);
              fy*point_Xd(2)+originpoint(2)
           ];



