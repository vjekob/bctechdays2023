table 50002 "Midjourney Result"
{
    Caption = 'Midjourney Result';
    TableType = Temporary;

    fields
    {
        field(1; Status; Enum "Midjourney Request Status")
        {
            Caption = 'Status';
        }

        field(2; Percentage; Decimal)
        {
            Caption = 'Percentage';
        }

        field(3; URL; Text[250])
        {
            Caption = 'URL';
        }

        field(4; "Error Message"; Text[250])
        {
            Caption = 'Error Message';
        }
    }
}