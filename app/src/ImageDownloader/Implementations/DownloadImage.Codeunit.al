codeunit 50013 "Download Image" implements IImageDownloader
{
    procedure Download(url: Text): InStream;
    begin
        exit(DownloadImageFromURL(Url));
    end;

    procedure DownloadImageFromURL(URL: Text) Instr: InStream
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

}