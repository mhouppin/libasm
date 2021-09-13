%ifdef MACOS_KERN
%define C_FUNCTION(x) _ %+ x
%elifdef LINUX_KERN
%define C_FUNCTION(x) x
%else
%error "Unknown kernel"
%endif