function modelo = entrenarSVM(X,Y,C,sigma,prob)
    
    options = ['-s 0 -t 2 -g',' ',num2str(sigma),' -c',' ',num2str(C),' -b ',num2str(prob),' -q'];
    modelo = svmtrain(Y,X,options);

end