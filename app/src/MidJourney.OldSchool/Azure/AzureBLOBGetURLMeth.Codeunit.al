codeunit 50003 "Azure BLOB Get URL Meth"
{
    internal procedure GetPictureURL(var Item: Record Item) URL: Text[250]
    var
        IsHandled: Boolean;
    begin
        OnBeforeMethodName(Item, URL, IsHandled);
        DoMethodName(Item, URL, IsHandled);
        OnAfterMethodName(Item, URL);
    end;

    local procedure DoMethodName(var Item: Record Item; var URL: Text[250]; IsHandled: Boolean);
    var
        UploadMeth: Codeunit "Azure BLOB Upload Meth";
        NoMediaErr: Label 'Item %1 has no pictures.', Comment = '%1 is image no.';
    begin
        if IsHandled then
            exit;

        URL := Item."Picture URL (Azure BLOB)";
        if URL <> '' then
            exit;

        if Item.Picture.Count() = 0 then
            Error(NoMediaErr, Item."No.");

        URL := UploadMeth.Upload(Item.Picture.Item(1));
        Sleep(30000); // To give Azure and Midjourney enough time to properly cache the image across all CDNs
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeMethodName(var Item: Record Item; var URL: Text[250]; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterMethodName(var Item: Record Item; var URL: Text[250]);
    begin
    end;

}
