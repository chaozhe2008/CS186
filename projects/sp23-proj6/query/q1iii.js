// Task 1iii

db.ratings.aggregate([
    {
        $group: {
            _id: "$rating",
            rating: { $first: "$rating" },
            count: {$sum: 1}
        }
    },
    {$sort: {rating: -1}},
    {
        $project: {
            _id: 0,
            rating: 1,
            count: 1
        }
    }
]);