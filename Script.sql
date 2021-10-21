create table ticket_det as (
select tf.ticket_no, tf.flight_id , tf.fare_conditions,tf.amount, bp.boarding_no, bp.seat_no from ticket_flights tf 
left join boarding_passes bp on tf.flight_id = bp.flight_id and tf.ticket_no = bp.ticket_no )

select * from flights_det fd where flight_id = 64068

ALTER TABLE bookings.ticket_det ADD CONSTRAINT ticket_flights_primarykey PRIMARY KEY (ticket_no, flight_id)

ALTER TABLE bookings.ticket_det ADD CONSTRAINT ticket_flights_ticket_no_foreignkey FOREIGN KEY (ticket_no) REFERENCES tickets(ticket_no)

ALTER TABLE bookings.ticket_det ADD CONSTRAINT ticket_flights_flight_id_fkey FOREIGN KEY (flight_id) REFERENCES flights_det(flight_id)

insert into bookings (days_before)
select fd.scheduled_departure-b.book_date from bookings b join tickets t on b.book_ref = t.book_ref join boarding_passes bp  on t.ticket_no = bp.ticket_no join flights_det fd on bp.flight_id 
= fd.flight_id where b.book_ref = t.book_ref 

alter table bookings add column days_before interval


select fd.scheduled_departure - b.book_ref from bookings b inner join tickets t on b.book_ref = t.book_ref inner join ticket_det td on t.ticket_no = td.ticket_no inner join flights_det fd on td.flight_id 
= fd.flight_id

select avg(amount) from ticket_det td where fare_conditions = 'Economy'

CREATE UNIQUE INDEX ticket_det_flight_id_seat_no_key ON bookings.ticket_det USING btree (flight_id, seat_no)
ALTER TABLE bookings.flights_det ADD CONSTRAINT flights_flight_no_fkey FOREIGN KEY (flight_no) REFERENCES routes_det(flight_no)

ALTER TABLE bookings.boarding_passes ADD CONSTRAINT boarding_passes_ticket_no_foreignkey FOREIGN KEY (ticket_no, flight_id) REFERENCES ticket_det(ticket_no, flight_id)


create table aircraft as (
select s.aircraft_code,seat_no, fare_conditions, ad.model, ad."range" from seats s 
join aircrafts_det ad on s.aircraft_code = ad.aircraft_code )
ALTER TABLE bookings.aircraft ADD CONSTRAINT aircraft_primarykey PRIMARY KEY (aircraft_code, seat_no)
CREATE UNIQUE INDEX aircraft_pkey ON bookings.aircraft USING btree (aircraft_code, seat_no)


ALTER TABLE bookings.flights_det ADD CONSTRAINT flights_aircraft_code_fkey FOREIGN KEY (aircraft_code) REFERENCES aircraft(aircraft_code)

alter table ticket_det add column aircraft_code bpchar(3) 

insert into ticket_det (aircraft_code)
select fd.aircraft_code from ticket_det td 
join flights_det fd on td.flight_id = fd.flight_id



select count(aircraft_code) from flights_det fd where aircraft_code = 'SU9'

select * from ticket_det td where ticket_no = '0005432001570'

