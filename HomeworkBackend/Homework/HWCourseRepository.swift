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
class HWCourseRepository : RepositoryMySQL {
func createTable() throws ->  Int {
   let rs = try db.query("CREATE TABLE IF NOT EXISTS hWCourse (color VARCHAR(255), id BIGINT(20), name VARCHAR(255), period VARCHAR(255))")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: HWCourse) throws -> Int {
       	let sql = "INSERT INTO hWCourse(color,id,name,period) VALUES ( :color, :id, :name, :period)"
        let rs =  try db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":color", entity.color)
	try stmt.bind(":id", entity.id)
	try stmt.bind(":name", entity.name)
	try stmt.bind(":period", entity.period)
        }
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Insert(errorCode)
        }
        //return db.changes()
        return 0
    }
    
    func update(entity: HWCourse) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWCourse SET color=:color ,name=:name ,period=:period WHERE id = :id"
        try let rs =  db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":color", entity.color)
	try stmt.bind(":id", entity.id)
	try stmt.bind(":name", entity.name)
	try stmt.bind(":period", entity.period)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Update(errorCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWCourse) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWCourse WHERE id = :id"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Delete(errorCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWCourse? {
        let sql = "SELECT color,id,name,period FROM HWCourse WHERE id = :id"
        var columns = [Any]()
        try let rs =  db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnText(0))
			columns.append(stmt.columnInt64(1))
			columns.append(stmt.columnText(2))
			columns.append(stmt.columnInt64(3))
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Select(errorCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        let entity =  HWCourse()
		entity.color = columns[0] as? String
		entity.id = columns[1] as? Int64
		entity.name = columns[2] as? String
		entity.period = columns[3] as? String
	    return entity;
    }
    
    func list() throws -> [HWCourse] {
        let sql = "SELECT * FROM hWCourse "
        var entities = [HWCourse]()
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
                let entity =  HWCourse()
		entity.color = stmt.columnText(0)
		entity.id = stmt.columnInt64(1)
		entity.name = stmt.columnText(2)
		entity.period = stmt.columnInt64(3)
        	    entities.append(entity)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 36.58 minutes to type the 3658+ characters in this file.
 */


