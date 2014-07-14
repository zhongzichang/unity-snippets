using UnityEngine;
using System.Collections;

public class SpinObject : MonoBehaviour {
	
	// Use this for initialization
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () {
		
		if (Input.GetKey(KeyCode.LeftArrow) || Input.GetKey(KeyCode.A))
		{
			transform.RotateAround(transform.position, Vector3.up, 50 * Time.deltaTime);
		}
		
		if (Input.GetKey(KeyCode.RightArrow) || Input.GetKey(KeyCode.D))
		{
			transform.RotateAround(transform.position, Vector3.up, -50 * Time.deltaTime);
		}
		
		if (Input.GetKey(KeyCode.UpArrow) || Input.GetKey(KeyCode.W))
		{
			transform.RotateAround(transform.position, Vector3.right, -50 * Time.deltaTime);
		}
		
		if (Input.GetKey(KeyCode.DownArrow) || Input.GetKey(KeyCode.S))
		{
			transform.RotateAround(transform.position, Vector3.right, 50 * Time.deltaTime);
		}
		
	}
}
