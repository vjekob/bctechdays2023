codeunit 50043 "GeneratePrompt Meth"
{
    internal procedure GeneratePrompt(var MidJourneyTestPrompt: Record "MidJourney Test Prompt"; CustomPrompt: Text; MidJourneyPromptFactory: Codeunit "MidJourney Prompt Factory") Prompt: Text
    var
        IsHandled: Boolean;
    begin
        OnBeforeGeneratePrompt(MidJourneyTestPrompt, Prompt, MidJourneyPromptFactory, IsHandled);

        DoGeneratePrompt(MidJourneyTestPrompt, CustomPrompt, Prompt, MidJourneyPromptFactory, IsHandled);

        OnAfterGeneratePrompt(MidJourneyTestPrompt, Prompt);
    end;

    local procedure DoGeneratePrompt(var MidJourneyTestPrompt: Record "MidJourney Test Prompt"; CustomPrompt: TExt; var Prompt: Text; MidJourneyPromptFactory: Codeunit "MidJourney Prompt Factory"; IsHandled: Boolean);
    var
        MidJourneyPrompts: Interface "IMidJourneyPrompt";
    begin
        if IsHandled then
            exit;

        MidJourneyPrompts := MidJourneyPromptFactory.PromptFactory();
        Prompt := MidJourneyPrompts.Prompt(MidJourneyTestPrompt.ImageUrl, MidJourneyTestPrompt.Setting, MidJourneyTestPrompt.Style, MidJourneyTestPrompt."Aspect Ratio", CustomPrompt);
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGeneratePrompt(var MidJourneyTestPrompt: Record "MidJourney Test Prompt"; var Prompt: Text; MidJourneyPromptFactory: Codeunit "MidJourney Prompt Factory"; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGeneratePrompt(var MidJourneyTestPrompt: Record "MidJourney Test Prompt"; var Prompt: Text);
    begin
    end;
}