function[loss,gradient]=logisticloss(y,p)   
    gradient= -1./(1+exp(-y'.*p)).*exp(-y'.*p).*(-y');
    loss=sum(log(1+exp(-y'.*p)));
end 
