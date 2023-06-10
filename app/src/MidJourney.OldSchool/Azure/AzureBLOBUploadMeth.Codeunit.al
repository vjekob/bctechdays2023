codeunit 50008 "Azure BLOB Upload Meth"
{
    internal procedure Upload(MediaId: Guid) URL: Text;
    var
        IsHandled: Boolean;
    begin
        OnBeforeUpload(MediaId, URL, IsHandled);
        DoUpload(MediaId, URL, IsHandled);
        OnAfterUpload(MediaId, URL);
    end;

    local procedure DoUpload(MediaId: Guid; var URL: Text; IsHandled: Boolean);
    var
        Setup: Record "Midjourney Setup";
        TenantMedia: Record "Tenant Media";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
        Response: Codeunit "ABS Operation Response";
        Authorization: Interface "Storage Service Authorization";
        AzureBLOB: Codeunit "ABS Blob Client";
        Stream: InStream;
        FileName: Text;
    begin
        if IsHandled then
            exit;

        Setup.Get();
        Setup.TestField("Azure BLOB Account");
        Setup.TestField("Azure BLOB Container");
        Setup.TestField("Azure BLOB Root URL");
        Setup.TestAzureBLOBSharedKey();

        TenantMedia.SetLoadFields(Content, "Mime Type");
        TenantMedia.SetAutoCalcFields(Content);
        TenantMedia.Get(MediaId);
        TenantMedia.Content.CreateInStream(Stream);

        Authorization := StorageServiceAuthorization.CreateSharedKey(Setup.GetAzureBLOBSharedKey());
        AzureBLOB.Initialize(Setup."Azure BLOB Account", Setup."Azure BLOB Container", Authorization);

        FileName := GetFileName(MediaId, GetExtensionFromMimeType(TenantMedia."Mime Type"));
        Response := AzureBLOB.PutBlobBlockBlobStream(FileName, Stream);
        if not Response.IsSuccessful() then
            Error(Response.GetError());

        URL := Setup."Azure BLOB Root URL".Trim();
        if not URL.EndsWith('/') then
            URL += '/';
        URL += FileName;
    end;

    internal procedure GetExtensionFromMimeType(MimeType: Text[100]): Text
    var
        UnsupportedMimeTypeErr: Label 'Unsupported Mime Type: %1', Comment = '%1 is the unsupported mime type';
    begin
        case MimeType of
            'image/jpeg':
                exit('jpg');
            'image/png':
                exit('png');
            'image/gif':
                exit('gif');
        end;
        Error(UnsupportedMimeTypeErr, MimeType);
    end;

    internal procedure GetFileName(MediaId: Guid; Extension: Text[100]): Text
    var
        Crypto: Codeunit "Cryptography Management";
        Hash: Text;
    begin
        Hash := Crypto.GenerateHash(Format(MediaId), 1); // SHA1
        exit(StrSubstNo('%1.%2', Hash, Extension));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpload(MediaId: Guid; var URL: Text; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpload(MediaId: Guid; URL: Text);
    begin
    end;
}
