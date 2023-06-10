enum 50000 "Midjourney Task Type"
{
    Caption = 'Midjourney Task Type';
    Extensible = false;

    value(0; GetURL)
    {
        Caption = 'Get URL';
    }

    value(1; GetPrompt)
    {
        Caption = 'Get Prompt';
    }

    value(2; RunImagine)
    {
        Caption = 'Run Imagine';
    }

    value(3; GetResult)
    {
        Caption = 'Get Result';
    }

}
