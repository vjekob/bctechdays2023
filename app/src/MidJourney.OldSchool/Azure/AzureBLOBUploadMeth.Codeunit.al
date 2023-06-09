codeunit 50008 "Azure BLOB Upload Meth"
{
    internal procedure Upload(MediaId: Guid)
    var
        IsHandled: Boolean;
    begin
        OnBeforeUpload(MediaId, IsHandled);
        DoUpload(MediaId, IsHandled);
        OnAfterUpload(MediaId);
    end;

    local procedure DoUpload(MediaId: Guid; IsHandled: Boolean);
    var
        Setup: Record "Midjourney Setup";
        TenantMedia: Record "Tenant Media";
        StorageServiceAuthorization: Codeunit "Storage Service Authorization";
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
        AzureBLOB.PutBlobBlockBlobStream(FileName, Stream);
    end;

    internal procedure GetExtensionFromMimeType(MimeType: Text[100]): Text
    var
        UnsupportedMimeTypeErr: Label 'Unsupported Mime Type: %1', Comment = '%1 is the unsupported mime type';
    begin
        case MimeType of
            'image/jpeg':
                exit('.jpg');
            'image/png':
                exit('.png');
            'image/gif':
                exit('.gif');
        end;
        Error(UnsupportedMimeTypeErr, MimeType);
    end;

    internal procedure GetFileName(MediaId: Guid; Extension: Text[100]): Text
    begin
        exit(StrSubstNo('%1.%2', MediaId, Extension));
    end;

    [IntegrationEvent(false, false)]
    local procedure OnBeforeUpload(MediaId: Guid; var IsHandled: Boolean);
    begin
    end;

    [IntegrationEvent(false, false)]
    local procedure OnAfterUpload(MediaId: Guid);
    begin
    end;
}
