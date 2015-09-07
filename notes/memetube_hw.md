Memetube
=====

## Pre: 

videos.sql file:

```
$ createdb memetube
$ psql -d memetube -f videos.sql
```

##Instructions

Your task is to create an app where users can add and view meme videos from Youtube.

#### The requirements

Build a _memetube_ app.

Just like we did with the todo app, create the restful routes for `videos`.

The `index` will show a list of all the videos in our database.

The `new` page will render a form where you can add a new video with all the associated fields (see the `sql` file). This form will need to `create` a new video and insert it in to the database. Perhaps you can redirect to the newly created video page after?

The `show` page will display the single video you have clicked on from the id.

The `edit` page will render a form with all the inputs pre-filled with data about that video so you can edit the fields. When you submit the form, the video gets `updated`.

Finally, there should be a link to `delete` the video from the database.

The `edit` and `delete` will be on the `show` page!

#### Styling
 
Style the app and make it look good.

#### BONUS

- 
If you want to try and work out how to use the `put` and `delete` methods, look up _method override_.


##################################################
make sure your url reflects the path
how do u change id on table




