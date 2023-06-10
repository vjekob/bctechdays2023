codeunit 50044 "MidJourney Prompt Factory"
{
    #region PromptFactory
    var
        _PromptFactory: Interface "IMidJourneyPrompt";
        _PromptFactoryIsDefined: Boolean;

    procedure PromptFactory(): Interface "IMidJourneyPrompt"
    var
        DefaultImplementationCodeunit: Codeunit "MidJourney Prompt Impl.";
    begin
        if not _PromptFactoryIsDefined then
            SetPromptFactory(DefaultImplementationCodeunit);

        exit(_PromptFactory);
    end;

    local procedure SetPromptFactory(IPromptFactory: Interface "IMidJourneyPrompt")
    begin
        _PromptFactory := IPromptFactory;
        _PromptFactoryIsDefined := true;
    end;
    #endregion PromptFactory
}