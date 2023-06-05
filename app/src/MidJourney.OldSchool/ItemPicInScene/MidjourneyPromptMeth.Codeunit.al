codeunit 50004 "Midjourney Prompt Meth"
{
    internal procedure GetPrompt(Prompt: Enum "Midjourney Prompt"; URL: Text) PromptText: Text;
    var
        IsHandled: Boolean;
    begin
        OnBeforeGetPrompt(Prompt, URL, PromptText, IsHandled);
        DoGetPrompt(Prompt, URL, PromptText, IsHandled);
        OnAfterGetPrompt(Prompt, URL, PromptText);
    end;

    local procedure DoGetPrompt(Prompt: Enum "Midjourney Prompt"; URL: Text; var PromptText: Text; IsHandled: Boolean);
    var
        PromptErr: Label 'Unspecified prompt type.';
    begin
        if IsHandled then
            exit;

        case Prompt of
            "Midjourney Prompt"::Conference:
                PromptText := StrSubstNo('%1 in a conference room setting, photo, realistic --ar 1:1 --iw 1.25', URL);
            "Midjourney Prompt"::Office:
                PromptText := StrSubstNo('%1 in a modern office, photo, realistic --ar 1:1 --iw 1.25', URL);
            "Midjourney Prompt"::LivingRoom:
                PromptText := StrSubstNo('%1 in a living room, photo, realistic --ar 1:1 --iw 1.25', URL);
            "Midjourney Prompt"::Beach:
                PromptText := StrSubstNo('%1 on a beach, sunset, realistic --ar 1:1 --iw 1.25', URL);
            "Midjourney Prompt"::Bar:
                PromptText := StrSubstNo('%1 in a cafe, photo, realistic --ar 1:1 --iw 1.25', URL);
            else
                Error(PromptErr);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeGetPrompt(Prompt: Enum "Midjourney Prompt"; URL: Text; var PromptText: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterGetPrompt(Prompt: Enum "Midjourney Prompt"; URL: Text; var PromptText: Text);
    begin
    end;

}
