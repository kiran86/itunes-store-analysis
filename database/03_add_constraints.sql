-- Define constraints for the database tables
ALTER TABLE album
ADD CONSTRAINT fk_album_artist
FOREIGN KEY (artist_id) REFERENCES artist(artist_id);

ALTER TABLE track
ADD CONSTRAINT fk_track_album
FOREIGN KEY (album_id) REFERENCES album(album_id);

ALTER TABLE track
ADD CONSTRAINT fk_track_genre
FOREIGN KEY (genre_id) REFERENCES genre(genre_id);

ALTER TABLE track
ADD CONSTRAINT fk_track_media
FOREIGN KEY (media_type_id) REFERENCES media_type(media_type_id);

ALTER TABLE customer
ADD CONSTRAINT fk_customer_employee
FOREIGN KEY (support_rep_id) REFERENCES employee(employee_id);

ALTER TABLE invoice
ADD CONSTRAINT fk_invoice_customer
FOREIGN KEY (customer_id) REFERENCES customer(customer_id);

ALTER TABLE invoice_line
ADD CONSTRAINT fk_invoice_line_invoice
FOREIGN KEY (invoice_id) REFERENCES invoice(invoice_id);

ALTER TABLE invoice_line
ADD CONSTRAINT fk_invoice_line_track
FOREIGN KEY (track_id) REFERENCES track(track_id);

ALTER TABLE playlist_track
ADD CONSTRAINT fk_playlist_track_playlist
FOREIGN KEY (playlist_id) REFERENCES playlist(playlist_id);

ALTER TABLE playlist_track
ADD CONSTRAINT fk_playlist_track_track
FOREIGN KEY (track_id) REFERENCES track(track_id);
