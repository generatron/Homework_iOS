/* 
Copyright (c) 2016 NgeosOne LLC
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

   
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), 
 to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, 
 and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.

Engineered using http://www.generatron.com/

[GENERATRON]
Generator :   System Templates
Filename:     HWCourseRepository.swift
Description:  SQLite Persistence code for for HWCourse
Project:      Homework
Template: /PerfectSwift/server/EntityRepository.swift.vm
 */


import PerfectLib
class HWCourseRepository : Repository {
func createTable() throws -> {
   try db.execute("CREATE TABLE IF NOT EXISTS hWCourse (color TEXT, id NUMBER, name TEXT, period TEXT)")
   let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.CreateTable(errCode)
      }
}
func insert(entity: HWCourse) throws -> Int {
       	let sql = "INSERT INTO hWCourse(color,id,name,period) VALUES ( :color, :id, :name, :period)"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":color", entity.color)
			try stmt.bind(":id", entity.id)
			try stmt.bind(":name", entity.name)
			try stmt.bind(":period", entity.period)
        }
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Insert(errCode)
        }
        return db.changes()
    }
    
    func update(entity: HWCourse) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWCourse SET color=:color ,name=:name ,period=:period WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":color", entity.color)
			try stmt.bind(":id", entity.id)
			try stmt.bind(":name", entity.name)
			try stmt.bind(":period", entity.period)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Update(errCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWCourse) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWCourse WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Delete(errCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWCourse? {
        let sql = "SELECT color,id,name,period FROM HWCourse WHERE id = :id"
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnText(0))
			columns.append(stmt.columnInt(1))
			columns.append(stmt.columnText(2))
			columns.append(stmt.columnInt(3))
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Select(errCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        return HWCourse(
		color: columns[0] as? String
		,id: columns[1] as? Int64
		,name: columns[2] as? String
		,period: columns[3] as? String
        )
    }
    
    func list() throws -> [HWCourse] {
        let sql = "SELECT * FROM hWCourse "
        var entities = [HWCourse]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
        	entities.append(
        		HWCourse(
				color: columns[0] as? String
				,id: columns[1] as? Int64
				,name: columns[2] as? String
				,period: columns[3] as? String
        		)
        	)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 34.27 minutes to type the 3427+ characters in this file.
 */


