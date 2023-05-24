String mensApparelQuery = '*[_type == "Mens_Apparel"]';
String womensApparelQuery = '*[_type == "Womens_Apparel"]';
String mensFootWearQuery = '*[_type == "Mens_Shoe"]';
String womensFootWearQuery = '*[_type == "Womens_Shoe"]';
String nutritionQuery = '*[_type == "Nutrition"]';
String accessoriesQuery = '*[_type == "Gym_Accessories"]';
String fetchAllQuery =
    '*[_type == "Mens_Apparel" || _type == "Womens_Apparel" || _type == "Mens_Shoe" || _type == "Womens_Shoe" || _type == "Nutrition" || _type == "Gym_Accessories"]';
