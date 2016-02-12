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
Filename:     HWCourseListRepository.swift
Description:  SQLite Persistence code for for HWCourseList
Project:      Homework
Template: /PerfectSwift/server/EntityRepository.swift.vm
 */


import PerfectLib
class HWCourseListRepository : RepositoryMySQL {
func createTable() throws ->  Int {
   try let rs = db.query("CREATE TABLE IF NOT EXISTS hWCourseList (id Long)")
   let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.CreateTable(errorCode)
      }
      return 0;
}
func insert(entity: HWCourseList) throws -> Int {
       	let sql = "INSERT INTO hWCourseList(id) VALUES ( :id)"
        try let rs =  db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":id", entity.id)
        }
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Insert(errorCode)
        }
        //return db.changes()
        return 0
    }
    
    func update(entity: HWCourseList) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWCourseList SET  WHERE id = :id"
        try let rs =  db.query(sql) { (stmt:SQLiteStmt) -> () in
	try stmt.bind(":id", entity.id)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Update(errorCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWCourseList) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWCourseList WHERE id = :id"
        try db.query(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Delete(errorCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWCourseList? {
        let sql = "SELECT id FROM HWCourseList WHERE id = :id"
        var columns = [Any]()
        try let rs =  db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnInt64(0))
        }
        
        let errorCode = db.errorCode()
        if errorCode > 0 {
            throw RepositoryError.Select(errorCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        let entity =  HWCourseList()
		entity.id = columns[0] as? Int64
	    return entity;
    }
    
    func list() throws -> [HWCourseList] {
        let sql = "SELECT * FROM hWCourseList "
        var entities = [HWCourseList]()
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
                let entity =  HWCourseList()
		entity.id = stmt.columnInt64(0)
        	    entities.append(entity)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 29.62 minutes to type the 2962+ characters in this file.
 */


