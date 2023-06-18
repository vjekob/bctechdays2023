codeunit 50079 DefaultBlockedByEnvHandler implements IBlockedByEnvironmentHandler
{
    procedure HandleBlockedByEnvironment(Method: Text; URL: Text);
    var
        BlockedByEnvironmentErr: Label 'Calling Http APIs is blocked by your Business Central configuration.';
    begin
        Error(BlockedByEnvironmentErr);
    end;
}
