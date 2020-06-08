require_relative('../db/sql_runner')
require_relative('./animal')

class Note

    attr_reader :id
    attr_accessor :treatment_notes, :animal_id

    def initialize(options)
        @id = options['id'].to_i if options['id']
        @treatment_note = options['treatment_note']
        @animal_id = options['animal_id'].to_i
    end

    def save()
        sql = "INSERT INTO notes
        (treatment_note,
        animal_id
        )
        VALUES
        ($1, $2
        )
        RETURNING id"
        values = [@treatment_note, @animal_id]
        result = SqlRunner.run(sql, values)
        id = result.first['id']
        @id = id
    end

    def update()
        sql = "UPDATE notes
        SET treatment_note = $1 WHERE id = $2"
        values = [@treatment_note, @id]
        SqlRunner.run(sql, values)
    end


    def self.find_by_animal_id(animal_id)
        sql = "SELECT * FROM notes
        WHERE animal_id = $1"
        values = [animal_id]
        notes = SqlRunner.run(sql, values)
        return Note.map_items(notes)
    end

    def self.find_by_id(id)
        sql = "SELECT * FROM notes
        WHERE id = $1"
        values = [id]
        notes = SqlRunner.run(sql, values)
        return Note.map_item(notes)
    end


    def self.map_items(note_data)
        result = note_data.map { |note| Note.new( note )}
        return result
    end

    def self.map_item(note_data)
        result = Note.map_items(note_data)
        return result.first
    end
end