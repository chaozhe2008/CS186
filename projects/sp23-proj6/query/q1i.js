// Task 1i

db.keywords.aggregate([
    {
        $match: {
                $or: [
                    { keywords: { $elemMatch: { name: "marvel comic" } } },
                    { keywords: { $elemMatch: { name: "mickey mouse" } } }
                ]
            }
    },
    { $project: { _id: 0, keywords: 0 } },
    { $sort: { movieId: 1 } }
]);