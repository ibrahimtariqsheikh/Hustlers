export default {
    name: 'Mens_Shoe',
    type: 'document',
    title: 'Mens Shoe',
    fields: [
        {
            name: 'Product_Name',
            type: 'string',
            title: 'Product Name'
        },
        {
            name: 'Product_Description',
            type: 'text',
            title: 'Product Description'
        },
        {
            name: 'Price',
            type: 'number',
            title: 'Price'
        },
        {
            name: 'Rating',
            type: 'number',
            title: 'Rating'
        },
        {
            name: 'Image_URL',
            title: 'Image URL',
            type: 'array',
            of: [{ type: 'url' }],
            options: {
                layout: 'grid',
            },
        },
        {
            name: 'Stock_Qty',
            type: 'number',
            title: 'Stock Qty'
        },
        {
            name: 'Color',
            title: 'Color',
            type: 'array',
            of: [{ type: 'string' }],
            options: {
                layout: 'grid',
            },
        },
        {
            name: 'Size',
            title: 'Size',
            type: 'array',
            of: [{ type: 'string' }],
            options: {
                layout: 'grid',
                list: [
                    { title: '5', value: '5' },
                    { title: '6', value: '6' },
                    { title: '7', value: '7' },
                    { title: '8', value: '8' },
                    { title: '9', value: '9' },
                    { title: '10', value: '10' },
                    { title: '11', value: '11' },
                    { title: '12', value: '12' }
                ],
            }
        },
        {
            name: 'Category',
            type: 'reference',
            to: [{ type: 'Category' }],
            title: 'Category'
        },
    ]
}