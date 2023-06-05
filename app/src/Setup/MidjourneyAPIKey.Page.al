page 50001 "Midjourney API Key BCTD23"
{
    Caption = 'Midjourney API Key';
    PageType = StandardDialog;

    layout
    {
        area(Content)
        {
            field(APIKey; APIKey)
            {
                Caption = 'API Key';
                ApplicationArea = All;
                ToolTip = 'Specifies the API key for Midjourney API.';
            }
        }
    }

    var
        APIKey: Text;

    procedure GetAPIKey(): Text
    begin
        exit(APIKey);
    end;
}
