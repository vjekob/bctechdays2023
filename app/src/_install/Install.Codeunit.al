codeunit 50000 "Install"
{
    Subtype = Install;

    trigger OnInstallAppPerCompany()
    begin
        InstallSetup();
        PresetItemUrls();
    end;

    local procedure InstallSetup()
    var
        Setup: Record "Midjourney Setup";
        DoInsert: Boolean;
    begin
        if not Setup.Get() then
            DoInsert := true;

        if Setup."Midjourney URL".Trim() = '' then
            Setup."Midjourney URL" := 'https://api.midjourneyapi.io/v2/';

        if DoInsert then
            Setup.Insert()
        else
            Setup.Modify();
    end;

    local procedure PresetItemUrls()
    begin
        UpdateItem('1896-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402031703986187/1896-S_ATHENS_Desk.jpg');
        UpdateItem('1900-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402167213555802/1900-S_PARIS_Guest_Chair_black.jpg');
        UpdateItem('1906-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402278924652605/1906-S_ATHENS_Mobile_Pedestal.jpg');
        UpdateItem('1908-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402417558995095/1908-S_LONDON_Swivel_Chair_blue.jpg');
        UpdateItem('1920-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402528229904394/1920-S_ANTWERP_Conference_Table.jpg');
        UpdateItem('1925-W', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402660937670656/1925-W_Conference_Bundle_1-6.jpg');
        UpdateItem('1928-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402791208550491/1928-S_AMSTERDAM_Lamp.jpg');
        UpdateItem('1929-W', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117402997819981885/1929-W_Conference_Bundle_1-8.jpg');
        UpdateItem('1936-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403105865240586/1936-S_BERLIN_Guest_Chair_yellow.jpg');
        UpdateItem('1953-W', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403216787812382/1953-W_Guest_Section_1.jpg');
        UpdateItem('1960-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403309708410900/1960-S_ROME_Guest_Chair_green.jpg');
        UpdateItem('1964-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403410946330634/1964-S_TOKYO_Guest_Chair_blue.jpg');
        UpdateItem('1965-W', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403513207664750/1965-W_Conference_Bundle_2-8.jpg');
        UpdateItem('1968-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403623610134629/1968-S_MEXICO_Swivel_Chair_black.jpg');
        UpdateItem('1969-W', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403732284551169/1969-W_Conference_Package_1.jpg');
        UpdateItem('1972-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403825179983963/1972-S_MUNICH_Swivel_Chair_yellow.jpg');
        UpdateItem('1980-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117403933535633448/1980-S_MOSCOW_Swivel_Chair_red.jpg');
        UpdateItem('1988-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117404056307126362/1988-S_SEOUL_Guest_Chair_red.jpg');
        UpdateItem('1996-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117404180399796344/1996-S_ATLANTA_Whiteboard_base.jpg');
        UpdateItem('2000-S', 'https://cdn.discordapp.com/attachments/1114654370760491038/1117404255666581514/2000-S_SYDNEY_Swivel_Chair_green.jpg');
    end;

    local procedure UpdateItem(ItemNo: Code[20]; Url: Text)
    var
        Item: Record Item;
    begin
        if not Item.Get(ItemNo) then exit;

        if Item."Picture URL" <> Url then begin
            Item."Picture URL" := Url;
            Item.Modify();
        end
    end;
}