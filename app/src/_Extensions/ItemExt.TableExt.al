tableextension 50000 "Item Ext" extends Item
{
    fields
    {
        field(50000; "Picture URL (Azure BLOB)"; Text[250])
        {
            Caption = 'Picture URL (Azure BLOB)';
            DataClassification = CustomerContent;
        }
        field(50001; "Picture In Scene"; Media)
        {
            Caption = 'Picture 2';
            DataClassification = CustomerContent;
        }
        field(50002; "Alternative Picture"; Media)
        {
            Caption = 'Picture 2';
            DataClassification = CustomerContent;
        }
        field(50003; "Picture URL (MidJourney)"; Text[250])
        {
            Caption = 'Picture URL (MidJourney)';
            DataClassification = CustomerContent;
        }
    }

    procedure GetAzureBLOBURL(): Text;
    var
        GetURLMeth: Codeunit "Azure BLOB Get URL Meth";
        URL: Text;
    begin
        URL := GetURLMeth.GetPictureURL(Rec);
        exit(URL);
    end;

    procedure DownloadPicInSceneImage()
    var
        DownloadPicInSceneImageMeth: Codeunit "DownloadPicInSceneImage Meth";
    begin
        DownloadPicInSceneImageMeth.DownloadImage(Rec);
    end;

}