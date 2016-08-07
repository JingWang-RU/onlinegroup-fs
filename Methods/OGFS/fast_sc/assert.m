function retval = assert(expr)
retval = true;
if ~expr
    % error('Assertion failed');
    warning ('Assertion failed');
    retval = false;
end
return
end