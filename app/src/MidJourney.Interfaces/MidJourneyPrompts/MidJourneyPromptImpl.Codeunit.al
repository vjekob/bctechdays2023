codeunit 50045 "MidJourney Prompt Impl." implements IMidJourneyPrompt
{
    procedure Prompt(ImageUrl: Text; IMidJourneySetting: interface "IMidJourney Setting"; IMidJourneyStyle: interface "IMidJourney Style"; IMidJourneyAspectRatio: interface "IMidJourney Aspect Ratio"; IMidJourneyLighting: Interface "IMidJourney Lighting"; CustomPrompt: Text) Prompt: Text;
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

        CustomPrompt := FixCustomPrompt(CustomPrompt);
        if CustomPrompt <> '' then
            PromptList.Add(CustomPrompt);

        if IMidJourneyLighting.GetPrompt() <> '' then
            PromptList.Add(IMidJourneyLighting.GetPrompt());

        foreach TextInPrompt in PromptList do
            Prompt := Prompt + TextInPrompt + ', ';

        Prompt := CopyStr(Prompt, 1, StrLen(Prompt) - 2);

        prompt := prompt + ' ' + IMidJourneyAspectRatio.ARPrompt();
    end;

    procedure FixCustomPrompt(CustomPrompt: Text): Text
    begin
        CustomPrompt := delchr(CustomPrompt, '=', delchr(CustomPrompt, '=', 'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890 ,'));

        if CustomPrompt.EndsWith(',') then
            CustomPrompt := CopyStr(CustomPrompt, 1, StrLen(CustomPrompt) - 1);

        exit(CustomPrompt);
    end;
}