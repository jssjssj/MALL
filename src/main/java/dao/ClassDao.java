package dao;

import java.sql.Connection;

import util.*;

public abstract class ClassDao {
	protected Converter converter = new Converter();
	protected DBUtil db = new DBUtil();
}
