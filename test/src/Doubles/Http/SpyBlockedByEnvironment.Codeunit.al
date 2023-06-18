codeunit 50251 "Spy - BlockedByEnvironment" implements IBlockedByEnvironmentHandler
{
    var
        _invoked: Boolean;

    procedure HandleBlockedByEnvironment(Method: Text; URL: Text);
    begin
        _invoked := true;
    end;

    procedure IsInvoked(): Boolean
    begin
        exit(_invoked);
    end;
}
