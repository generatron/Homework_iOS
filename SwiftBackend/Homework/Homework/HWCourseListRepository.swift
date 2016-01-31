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
class HWCourseListRepository : Repository {
func createTable() throws ->  Int {
   try db.execute("CREATE TABLE IF NOT EXISTS hWCourseList (id NUMBER)")
   let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.CreateTable(errCode)
      }
      return 0;
}
func insert(entity: HWCourseList) throws -> Int {
       	let sql = "INSERT INTO hWCourseList(id) VALUES ( :id)"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":id", entity.id)
        }
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Insert(errCode)
        }
        return db.changes()
    }
    
    func update(entity: HWCourseList) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "UPDATE hWCourseList SET  WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
			try stmt.bind(":id", entity.id)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Update(errCode)
        }
        
        return db.changes()
    }
    
    func delete(entity: HWCourseList) throws -> Int {
        guard let id = entity.id else {
            return 0
        }
        
        let sql = "DELETE FROM hWCourseList WHERE id = :id"
        try db.execute(sql) { (stmt:SQLiteStmt) -> () in
            try stmt.bind(":id", id)
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Delete(errCode)
        }
        
        return db.changes()
    }
    
    func retrieve(id: Int) throws -> HWCourseList? {
        let sql = "SELECT id FROM HWCourseList WHERE id = :id"
        var columns = [Any]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            	try stmt.bind(":id", id)
        }) { (stmt:SQLiteStmt, r:Int) -> () in
			columns.append(stmt.columnInt(0))
        }
        
        let errCode = db.errCode()
        if errCode > 0 {
            throw RepositoryError.Select(errCode)
        }
        
        guard columns.count > 0 else {
            return nil
        }
        
        return HWCourseList(
		id: columns[0] as? Int64
        )
    }
    
    func list() throws -> [HWCourseList] {
        let sql = "SELECT * FROM hWCourseList "
        var entities = [HWCourseList]()
        try db.forEachRow(sql, doBindings: { (stmt:SQLiteStmt) -> () in
            //nothing to see here
        }) { (stmt:SQLiteStmt, r:Int) -> () in
        	entities.append(
        		HWCourseList(
				id: columns[0] as? Int64
        		)
        	)
        }
        return entities
    }
}

/* 
[STATS]
It would take a person typing  @ 100.0 cpm, 
approximately 28.01 minutes to type the 2801+ characters in this file.
 */

