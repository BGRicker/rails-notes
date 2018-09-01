GET /notes
Description: this produces an array containing all of the notes our application has in a JSON format.

GET /notes/:id
Description: get a specific note, when providing the id of the note in the database.

{
  id: 1,
  title: "Things To Do",
  content: "* Laundry * Haircut * Go to the gym",
  created_at: "2017-03-03T22:10:04.672Z",
  updated_at: "2017-03-17T19:18:49.175Z",
  tags: [
    {
      id: 1,
      name: "Tasks",
      note_id: 1,
      created_at: "2017-03-20T16:32:54.940Z",
      updated_at: "2017-03-20T16:32:54.940Z"
    }
  ]
}

POST /notes
Description: create a new note in the application.

{
  note: {
    title: "My new note",
    content: "Note content"
  }
}

PATCH /notes/:id
Description: update an existing note in the database.

{
  note: {
    title: "My new note",
    content: "Note content"
  }
}

DELETE /notes/:id
Description: deletes the note from the application.

POST /notes/:id/tags
Description: add a tag to the note that is found. This expects the following
fields to be present in the POST data of the request:

{
  tag: {
    name: "Fun",
  }
}

DELETE /tags/:id
Description: this removes the tag with the provided id from the application.
