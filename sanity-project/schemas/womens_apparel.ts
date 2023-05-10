export default {

    name: 'Womens_Apparel',
    type: 'document',
    title: 'Womens Apparel',
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
        }, {
            name: 'Price',
            type: 'number',
            title: 'Price'
        }, {
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
                    { title: 'Small', value: 'S' },
                    { title: 'Medium', value: 'M' },
                    { title: 'Large', value: 'L' },
                    { title: 'Extra Large', value: 'XL' },
                    { title: 'XX Large', value: 'XXL' },
                ]
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