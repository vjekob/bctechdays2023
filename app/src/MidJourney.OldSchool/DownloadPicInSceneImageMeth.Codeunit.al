codeunit 50056 "DownloadPicInSceneImage Meth"
{
    internal procedure DownloadImage(var Item: Record Item)
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownloadImage(Item, IsHandled);

        DoDownloadImage(Item, IsHandled);

        OnAfterDownloadImage(Item);
    end;

    local procedure DoDownloadImage(var Item: Record Item; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        Item."Pic-In-Scene".ImportStream(DownloadImageFromURL(Item."Pic-In-Scene URL (MidJourney)"), 'MidJourney');
        Item.Modify(true);
    end;

    local procedure DownloadImageFromURL(URL: Text) Instr: InStream
    var
        HttpClient: HttpClient;
        Response: HttpResponseMessage;
        TempBlob: Codeunit "Temp Blob";
    begin
        if not HttpClient.Get(url, Response) then begin
            Error('Error downloading image from URL: %1', url);
        end;
        if not Response.IsSuccessStatusCode then begin
            Error('Error downloading image from URL: %1', url);
        end;

        TempBlob.CreateInStream(Instr);

        if not Response.Content.ReadAs(Instr) then begin
            Error('Invalid image from URL: %1', url);
        end;
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeDownloadImage(var Item: Record Item; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownloadImage(var Item: Record Item);
    begin
    end;
}