codeunit 50045 "MidJourney Prompt Impl." implements IMidJourneyPrompt
{
    procedure Prompt(ImageUrl: Text; IMidJourneySetting: interface "IMidJourney Setting"; IMidJourneyStyle: interface "IMidJourney Style"; IMidJourneyAspectRatio: interface "IMidJourney Aspect Ratio"; CustomPrompt: Text) Prompt: Text;
    var
        PromptList: List of [Text];
        TextInPrompt: Text;
    begin
        If ImageUrl <> '' then
            PromptList.Add(ImageUrl);

        if IMidJourneySetting.GetSettingPrompt() <> '' then
            PromptList.Add(IMidJourneySetting.GetSettingPrompt());

        if IMidJourneyStyle.GetStylePrompt() <> '' then
            PromptList.Add(IMidJourneyStyle.GetStylePrompt());

        CustomPrompt := delchr(CustomPrompt, '=', delchr(CustomPrompt, '=', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 '));
        if CustomPrompt <> '' then
            PromptList.Add(CustomPrompt);

        foreach TextInPrompt in PromptList do
            Prompt := Prompt + TextInPrompt + ', ';

        Prompt := CopyStr(Prompt, 1, StrLen(Prompt) - 2);

        prompt := prompt + ' ' + IMidJourneyAspectRatio.ARPrompt();
    end;
}