codeunit 50056 "ImportItemPicInScene Meth"
{
    internal procedure ImportImage(Url: Text; var Item: Record Item)
    var
        IsHandled: Boolean;
    begin
        OnBeforeDownloadImage(Url, Item, IsHandled);

        DoDownloadImage(Url, Item, IsHandled);

        OnAfterDownloadImage(Url, Item);
    end;

    local procedure DoDownloadImage(Url: Text; var Item: Record Item; IsHandled: Boolean);
    begin
        if IsHandled then
            exit;

        Item."Pic-In-Scene URL (MidJourney)" := Url;
        Item."Pic-In-Scene".ImportStream(DownloadImageFromURL(Url), 'MidJourney');
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
    local procedure OnBeforeDownloadImage(Url: Text; var Item: Record Item; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterDownloadImage(Url: Text; var Item: Record Item);
    begin
    end;
}