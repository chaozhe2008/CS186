// Task 2ii

db.movies_metadata.aggregate([
    {
        $project:{
            split:{
                $split:["$tagline", " "]
            }
        }
    },
    {
        $unwind: "$split"
    },
    {
        $project:{
            lower:{$trim: {input: {$toLower: "$split"}, chars: " ,.!?"}}
        }
    },

    {
        $project:{
            lower: 1,
            len: {$strLenCP: "$lower"}
        }
    },
    {$match: {len: {$gt: 3}}},
    {
        $group :{
            _id: "$lower",
            count: {$sum: 1}
        }
    },
{$sort: {count: -1}},
{$limit: 20}
]);